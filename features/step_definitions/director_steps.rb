Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
  end
end

Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |e1, e2|
   regexp = /#{e1}.+Director.+#{e2}/m
   page.body.to_s =~ regexp
end

#When /^(?:|I )follow "([^"]*)"$/ do |link|
#  find(:id).text
#	debugger
#  click_link(link)
#end

#When /^(?:|I )follow "([^"]*)"$/ do |parameter|	
#	element[:src].should include :controller
#end

#When /^(?:|I )follow "([^"]*)"$/ do |value|
#  selector = %{//div[@data-value="#{value}"]}
#  error_message = "Could not find answer for value '#{value}'."
#  page.locate(:xpath, selector, error_message).click
#end

#Then /^(?:|I )should be on the Similar Movies page for (.+)$/ do |page_name|
#  visit path_to(page_name)
#end

#And /^(?:|I )should see "([^"]*)"$/ do |text|
#  if page.respond_to? :should
#    page.should have_content(text)
#  else
#    assert page.has_content?(text)
#  end
#end

#But /^(?:|I )should not see "([^"]*)"$/ do |text|
#  if page.respond_to? :should
#    page.should have_no_content(text)
#  else
#    assert page.has_no_content?(text)
#  end
#end

#Then /^(?:|I )should be on the (.+)$/ do |page_name|
#  visit path_to(page_name)
#end
