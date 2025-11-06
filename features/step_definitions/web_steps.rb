Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )press "([^"]*)"$/ do |button|
  click_button(button)
end

When /^(?:|I )follow "([^"]*)"$/ do |link|
  click_link(link)
end

When /^(?:|I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, with: value)
end

When /^(?:|I )select "([^"]*)" from "([^"]*)"$/ do |value, field|
  select(value, from: field)
end

When /^(?:|I )check "([^"]*)"$/ do |field|
  check(field)
end

When /^(?:|I )uncheck "([^"]*)"$/ do |field|
  uncheck(field)
end

When /^(?:|I )choose "([^"]*)"$/ do |field|
  choose(field)
end

Then /^(?:|I )should see "([^"]*)"$/ do |text|
  expect(page).to have_content(text)
end

Then /^(?:|I )should not see "([^"]*)"$/ do |text|
  expect(page).to have_no_content(text)
end

Then /^I should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  expect(current_path).to eq(path_to(page_name))
end

module NavigationHelpers
  def path_to(page_name)
    case page_name
    when /^the RottenPotatoes home page$/
      movies_path
    when /^the details page for "([^"]*)"$/
      movie = Movie.find_by_title($1)
      movie_path(movie)
    when /^the "Similar Movies" page for "([^"]*)"$/
      movie = Movie.find_by_title($1)
      search_directors_path(movie)
    else
      raise "Can't find mapping from \"#{page_name}\" to a path."
    end
  end
end

World(NavigationHelpers)
