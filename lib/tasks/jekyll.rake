# namespace :jekyll do
#   dest = Rails.public_path.join('blog')

#   options = {
#     'baseurl' => '/blog',
#     'config' => Rails.root.join('config', 'jekyll.yml').to_s,
#     'watch' => true,
#     'port' => 3000,
#     'source' => Rails.root.join('blog').to_s,
#     'destination' => dest.to_s
#   }

#   build = Thread.new { Jekyll::Commands::Build.process(options) }
#   serve = Thread.new { Jekyll::Commands::Serve.process(options) }

#   commands = [build, serve]
#   commands.each(&:join)
# end

namespace :jekyll do
  desc 'Rebuild Jekyll posts'
  task build: :environment do
    `bundle exec jekyll build -s ./blog/ -d public/blog/ --config config/jekyll.yml`
  end
end
