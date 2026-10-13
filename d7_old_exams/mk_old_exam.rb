
puts "| 年度 | 種別  | 問題      | 解答例    | 参考資料    |"


dir = "21_pre"
Dir.glob('*_*').reverse.each do |dir|
  next unless File.directory?(dir)
  line_cont = {prob: [], ans: [], ref: []}
  line = Dir.chdir(dir) do
    year, head = dir.split("_")
    Dir.glob("*.*").each do |file|
      ext = File.extname(file)
      next if %w[.tex .bb .png .html .mw].include?(ext)
      link = "[[#{['.', dir, file].join('/')}][#{ext}]]"
      case file
      when /ans/
        next if ".pdf".include?(ext)
        line_cont[:ans] << link
      when /ref/
        line_cont[:ref] << link
      else
        next if ".pdf".include?(ext)
        line_cont[:prob] << link
      end
    end
    ['20'+year,head, line_cont[:prob].join(','),
     line_cont[:ans].join(','),
     line_cont[:ref].join(',')].join('|')
  end
  puts '|'+line
end
