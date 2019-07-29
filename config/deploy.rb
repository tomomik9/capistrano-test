# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

# アプリ名
set :application, "BookApp"
set :repo_url, "git@github.com:tomomik9/capistrano-test.git"
set :user, "tomomik9"

# デプロイ先のパス
set :deploy_to, "/home/tomomik9/Deploy/"

# ログ関係の設定（ 詳しくはこちら -> https://qiita.com/hirokishirai/items/50b319133f19f20382f4 )
set :format, :airbrussh
set :format_options, command_output: true, log_file: "log/capistrano.log", color: :true, truncate: :false

# Sudoするために必要な設定 ( 詳しくはこちら -> https://qiita.com/kasei-san/items/3edb52359ff288d2f435 )
set :pty, true

# リリースをどこまで残すか
set :keep_releases, 5

# puma の設定
set :puma_threads,    [4, 16]
set :puma_workers,    0
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.access.log"
set :puma_error_log,  "#{release_path}/log/puma.error.log"
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true

# rbenv の設定
set :rbenv_type, :user
set :rbenv_path, '/home/tomomik9/.rbenv'
set :rbenv_ruby, File.read('.ruby-version').strip
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w[rake gem bundle ruby rails puma pumactl]

# シンボリックリンク貼る系（dir）
set :linked_dirs, fetch(:linked_dirs, []).push(
  'log',
  'tmp/pids',
  'tmp/cache',
  'tmp/sockets',
  'vendor/bundle',
  'public/system',
  'public/uploads'
)
# シンボリックリンク貼る系（file）
set :linked_files, fetch(:linked_files, []).push(
  'config/database.yml',
  'config/credentials.yml.enc',
  '.env'
)


namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end
  before :start, :make_dirs
end

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/#{fetch(:branch)}`
        puts "WARNING: HEAD is not the same as origin/#{fetch(:branch)}"
        puts "Run `git push origin HEAD` to sync changes."
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  desc '必要なファイルをアップロード'
  task :upload do
    on roles(:app) do |host|
      if test "[ ! -d #{shared_path}/config ]"
        execute "mkdir #{shared_path}/config -p"
      end
      upload!('config/credentials.yml.enc', "#{shared_path}/config/credentials.yml.enc")
    end
  end

  before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup

  desc 'setup nginx'
  task :nginx do
    on roles(:app) do |host|
      # 後ほど作成するnginxのファイル名を記述してください
      %w[BookApp.conf].each do |f|
        upload! "config/#{f}", "#{shared_path}/config/#{f}"
        sudo :cp, "#{shared_path}/config/#{f}", "/etc/nginx/conf.d/#{f}"
        sudo "nginx -s reload"
      end
    end
  end
end

