module EmojiHelper
  def emojify(content)
    h(content).to_str.gsub(/:([\w+-]+):/) do |match|
      if emoji = Emoji.find_by_alias($1)
        %(<img alt="#$1" src="#{asset_path("emoji/#{emoji.image_filename}")}" style="vertical-align: middle; margin-bottom: 5px;" width="32" height="32" />)
      else
        match
      end
    end.html_safe if content.present?
  end
end