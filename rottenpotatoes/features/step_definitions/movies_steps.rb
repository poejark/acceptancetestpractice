
Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create movie
  end
end

# Given /I am on the details page for "(.*)"/ do |title|
# #   Ok I'm assuming chronology with the ids
#   click_button("More about " + title)
# end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page.body.index(e1) < page.body.index(e2))
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(', ').each do |rating|
    step %{I #{uncheck.nil? ? '' : 'un'}check "ratings_#{rating}"}
  end
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  Movie.all.each do |movie|
    step %{I should see "#{movie.title}"}
  end
end

# When /I go to the edit page for "(.*)"/ do |title|
# #   Uh do I perhaps use the path_to helper? Cuz figuring out which id to call is a bit confounding 
#   click_button("More about " + title)
#   click_button("Edit")
# end

Then /the director of "(.*)" should be "(.*)"/ do |title, director|
#   Expect the director to be sandwhiched between the relevant row. 
  visit path_to("home")
  expect(page.body).to match(/#{title}.*#{director}.*#{"More about " + title}/m)
end


