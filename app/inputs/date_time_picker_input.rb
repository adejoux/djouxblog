#source from : https://gist.github.com/nacengineer/5706663

class DateTimePickerInput < SimpleForm::Inputs::Base
  def input
    template.content_tag(:div, class: 'datetimepicker input-append') do
      template.concat @builder.text_field(attribute_name, input_html_options) + span_div
    end
  end

  def input_html_options
    {'data-format' => "dd/MM/yyyy HH:mm PP"}
  end

  def span_div
    template.content_tag(:span, class: 'add-on') do
      template.concat icon_div.html_safe
    end
  end

  def icon_div
    "<i class='icon-calendar' data-time-icon='icon-time' data-date-icon='icon-calendar'></i>"
  end
end
