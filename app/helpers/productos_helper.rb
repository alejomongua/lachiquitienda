module ProductosHelper
  def precio (p)
    if p.to_i % 1000 == 0
      "$#{p.to_i / 1000} <span class='precio-centenas'>mil</span>"
    else
      "$" + p.to_s.gsub(/\d\d\d/,'<span class="precio-centenas">\1\2\3</span>')
    end
  end
end
