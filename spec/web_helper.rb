def sign_up
  visit '/'
  click_link 'Sign up'
  fill_in 'Email', with: 'bob@bob.com'
  fill_in 'Password', with: '123456'
  fill_in 'Password confirmation', with: '123456'
  click_button 'Sign up'
end

def sign_in
  visit '/'
  click_link 'Sign in'
  fill_in 'Email', with: 'bob@bob.com'
  fill_in 'Password', with: '123456'
  click_button 'Log in'
end
