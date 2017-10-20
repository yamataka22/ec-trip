module AdminHelper
  def admin_breadcrumb(crumbs)
    return if crumbs.nil?
    content_tag :ol, class: 'breadcrumb' do
      crumbs.each_with_index do |crumb, i|
        if i == crumbs.size - 1
          concat (content_tag :li, crumb[:title], class: 'breadcrumb-item active')
        else
          concat (content_tag :li, (link_to crumb[:title], crumb[:path]), class: 'breadcrumb-item')
        end
      end
    end
  end
end