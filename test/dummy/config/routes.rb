Rails.application.routes.draw do
  match 'abc', controller: "application", action: "options", via: :options
end
