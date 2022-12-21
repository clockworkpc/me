namespace :draft do
  foo = 'bar'

  desc 'foo bar'
  task :foo do
    puts 'hello world'
  end

  desc 'Creating a new draft for post/entry'
  task new: :environment do
    puts "What's the name for your next post?"
    @name = $stdin.gets.chomp
    @slug = @name.to_s
    @slug = @slug.tr('ÁáÉéÍíÓóÚú', 'AaEeIiOoUu')
    @slug = @slug.downcase.strip.tr(' ', '-')
    FileUtils.touch("blog/_drafts/#{@slug}.md")
    open("blog/_drafts/#{@slug}.md", 'a') do |file|
      file.puts '---'
      file.puts 'layout: post'
      file.puts "title: #{@name}"
      file.puts 'description: maximum 155 char description'
      file.puts 'category: blog'
      file.puts 'tag: blog'
      file.puts '---'
    end
  end

  desc 'copy draft to production post!'
  task ready: :environment do
    Time.zone = 'America/New_York'
    puts 'Posts in _drafts:'
    Dir.foreach('blog/_drafts') do |fname|
      next if ['.', '..', '.keep'].include?(fname)

      puts fname
    end
    puts "what's the name of the draft to post?"
    @post_name = $stdin.gets.chomp
    @post_date = Time.zone.now.strftime('%F')
    FileUtils.mv("blog/_drafts/#{@post_name}", "blog/_posts/#{@post_name}")
    FileUtils.mv("blog/_posts/#{@post_name}", "blog/_posts/#{@post_date}-#{@post_name}")
    puts 'Post copied and ready to deploy!'
  end
end
