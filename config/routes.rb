# frozen_string_literal: true

Rails.application.routes.draw do
  resource :game, only: %i[new create update]
  root "games#new"
  get "*path", to: redirect("/")
end
