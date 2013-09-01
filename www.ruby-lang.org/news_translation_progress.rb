# Written by: Marcin Szczepaniak (crabonature)
#
# Feel free to use it. MIT license.

# Script for generating Markdown file with status of translation news articles
# into specified language. If someone commit file with different name than original
# it will resolve that article as not translated. 

# You want to change this path
@path_to_repo = "#{Dir.home}/arch_proj/open_source_contributions/www.ruby-lang.org"
# You want to change this language
@our_language = 'pl'
#Here comes output in Markdown
@output_file = 'translation_status.md'
@base_language = 'en'

# Finds all news files for specified language.
def find_news_files(language)
  path = Dir.chdir("#@path_to_repo/#{language}/news/_posts")
  Dir.glob(File.join("**", "*.md")).sort.reverse!
end

# Resolves title of original news
def resolve_original_news_title(file)
  File.open("#@path_to_repo/#@base_language/news/_posts/#{file}", mode="r") do |opened_file|
    opened_file.readlines[2][/".*"/]
  end 
end

File.open("#@output_file", mode="w") do |opened_file|
  our_language_files = find_news_files(@our_language)

  find_news_files(@base_language).each do |file|
    title = resolve_original_news_title(file)
    if our_language_files.include?(file)
      opened_file << "- [x] **"
    else
      opened_file << "- [ ] **"
    end
    opened_file << title << "** - #{file}\n"
  end
end



