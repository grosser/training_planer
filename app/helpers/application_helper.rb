module ApplicationHelper
  def bootstrap_will_paginate(collection, options={})
    will_paginate(collection, options.merge(:renderer => WillPaginate::ActionView::BootstrapLinkRenderer))
  end

  def nbsp(count=1)
    ("&nbsp;" * count).html_safe
  end

  def input_row(f, field, &block)
    input = if block_given?
      capture(&block)
    else
      f.text_field field
    end

    <<-HTML.html_safe
    <div class="clearfix">
      #{f.label field}
      <div class="input">#{ input }</div>
    </div>
    HTML
  end

  def form_button(f)
    f.submit (f.object.new_record? ? 'Create' : 'Save'), :class => 'btn primary'
  end
end
