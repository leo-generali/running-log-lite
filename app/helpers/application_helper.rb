module ApplicationHelper

  def active_class(link_path)
    current_page?(link_path) ? "sidebar-item sidebar-item--link sidebar-item--link--active" : "sidebar-item sidebar-item--link"
  end

end
