# frozen_string_literal: true

module ViewHelper
  def format_currency(num)
    "$ #{format('%7.2f', num)}"
  end

  def recurring?(transaction)
    if transaction.recurring?
      '<i class="fas fa-stopwatch"></i>'
    else
      ''
    end
  end

  def name_helper(transaction)
    if transaction.domain
      href(transaction.domain, transaction.name)
    else
      transaction.name
    end
  end

  def href(url, text)
    %(<a href="http://#{url}">#{text}</a>)
  end

  def delete_link_js(id, route, redirect)
    %[$('#{id}').on('click', function(e) {
         $.post('#{route}', {_method: 'delete'}, function() { window.location.href = '#{redirect}' });
       });]
  end

  def logo_helper(transaction)
    if transaction.logo
      %(<img src="#{transaction.logo}" class="rounded-circle thumbnail" />)
    elsif transaction.interest?
      '<i class="fas fa-hand-holding-usd"></i>'
    else
      default_icons(transaction.categories)
    end
  end

  private

  def default_icons(categories)
    DefaultIcon.get(categories) || '<i class="fas fa-file"></i>'
  end
end
