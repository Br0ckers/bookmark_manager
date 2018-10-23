feature 'Viewing bookmarks' do
  scenario 'visiting the index page' do
    visit('/')
    expect(page).to have_content "Bookmark Manager"
  end
  scenario 'expect page to return some urls or links' do
    visit('/')
    have_link(:href => "bookmarks")
  end

  scenario 'click link for view' do
    visit('/')
    click_link 'View Bookmarks'
    expect(page).to have_content "array of bookmarks"
  end

  scenario 'A user can see bookmarks' do
    connection = PG.connect(dbname: 'bookmark_manager_test')
    # Add the test data
    connection.exec("INSERT INTO bookmarks VALUES(1, 'http://www.makersacademy.com');")
    connection.exec("INSERT INTO bookmarks VALUES(2, 'http://www.destroyallsoftware.com');")
    connection.exec("INSERT INTO bookmarks VALUES(3, 'http://www.google.com');")

    visit('/bookmarks')

    expect(page).to have_content "http://www.makersacademy.com"
    expect(page).to have_content "http://www.destroyallsoftware.com"
    expect(page).to have_content "http://www.google.com"
  end

end

feature 'Adding bookmarks' do
  scenario 'Adding a bookmark' do

    connection = PG.connect(dbname: 'bookmark_manager_test')

    connection.exec("INSERT INTO bookmarks VALUES(1, 'http://www.makersacademy.com');")
    connection.exec("INSERT INTO bookmarks VALUES(2, 'http://www.destroyallsoftware.com');")
    connection.exec("INSERT INTO bookmarks VALUES(3, 'http://www.google.com');")

    visit('/')
    click_link 'View Bookmarks'

    click_button('Add')
    fill_in('URL', :with => 'http://www.bbc.co.uk')
    click_button('Add')
    click_button('View')

    expect(page).to have_content "http://www.makersacademy.com"
    expect(page).to have_content "http://www.destroyallsoftware.com"
    expect(page).to have_content "http://www.google.com"
    expect(page).to have_content "http://www.bbc.co.uk"
  end
  scenario 'Adding a bookmark' do

    connection = PG.connect(dbname: 'bookmark_manager_test')

    connection.exec("INSERT INTO bookmarks VALUES(1, 'http://www.makersacademy.com');")
    connection.exec("INSERT INTO bookmarks VALUES(2, 'http://www.destroyallsoftware.com');")
    connection.exec("INSERT INTO bookmarks VALUES(3, 'http://www.google.com');")

    visit('/')
    click_link 'View Bookmarks'

    click_button('Add')
    fill_in('URL', :with => 'http://www.bbc.co.uk')
    click_button('Add')
    fill_in('URL', :with => 'http://www.youtube.co.uk')
    click_button('Add')
    click_button('View')

    expect(page).to have_content "http://www.makersacademy.com"
    expect(page).to have_content "http://www.destroyallsoftware.com"
    expect(page).to have_content "http://www.google.com"
    expect(page).to have_content "http://www.bbc.co.uk"
    expect(page).to have_content "http://www.youtube.co.uk"
  end
end
