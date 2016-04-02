Given(/^the following movies exist:$/) do |table|
    table.hashes.each do |movie|
        Movie.create(movie)
    end
end

When(/^fill in "(.*?)" with "(.*?)"$/) do |arg1, arg2|
    fill_in(arg1,arg2)
end

When(/^press "(.*?)"$/) do |arg1|
    click_button(arg1)
end

Then(/^the director of "(.*?)" should be "(.*?)"$/) do |arg1, arg2|
    Movie.where(title:arg1).first.director == arg2
end

When(/^follow "(.*?)"$/) do |arg1|
    click_link(arg1)
end

Then(/^the Similar Movies page for "(.*?)"$/) do |arg1|
    current_path.should == path_to(arg1)
end

Then(/^should see "(.*?)"$/) do |arg1|
    page.should have.content(arg1)
end

Then(/^should not see "(.*?)"$/) do |arg1|
    page.should have_no_content(arg1)
end

Then(/^be on the home page$/) do
    current_path.should == movies_path
end