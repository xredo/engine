require 'active_support/all'
require 'pundit'
module Locomotive
  class API < Grape::API

    helpers Pundit
    helpers APIAuthenticationHelpers
    helpers APIParamsHelper
    helpers PersistenceHelper

    content_type :xml, 'application/xml'
    content_type :json, 'application/json'

    format :xml
    format :json

    prefix 'v2'

    rescue_from Pundit::NotAuthorizedError do
      error_response(message: { 'error' => '401 Unauthorized' }, status: 401)
    end

    mount Resources::TokenAPI
    mount Resources::TranslationAPI
    mount Resources::VersionAPI
    mount Resources::ThemeAssetAPI
    mount Resources::SiteAPI

  end
end
