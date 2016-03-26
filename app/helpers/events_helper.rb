module EventsHelper
  def header_background_image_url
    "https://az810058.vo.msecnd.net/site/global/Content/img/home-search-bg-0#{rand(6)}.jpg"
  end

  def edit_button(event)
    if can_edit?(event)
      link_to('Edit', edit_event_path(event), class: 'btn btn-primary btn-lg btn-block')
    end
  end

  def can_edit?(event)
    event.admins.ids.include?(current_user.id)
  end
end
