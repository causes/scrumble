require 'sinatra/base'
require 'haml'
require 'sass'

class ScrumApp < Sinatra::Base
  SIMPLE_STATES = {
    :new  => %w[unscheduled unstarted rejected],
    :work => %w[started finished],
    :done => %w[delivered accepted],
  }

  STATE_ORDER = %w[unscheduled unstarted rejected
                   started finished
                   delivered accepted]

  get '/' do
    @date = Date.parse(params[:since]) rescue (Date.today - 1)
    @projects = Project.active(@date)
    haml :index
  end

  get '/stylesheets/:style.css' do
    sass params['style'].to_sym
  end

  helpers do
    def simple_state(state)
      SIMPLE_STATES.find{|k, v| v.include?(state)}.first
    end

    def by_state(stories)
      stories.group_by(&:current_state).sort_by do |state, stories|
        STATE_ORDER.index(state)
      end
    end

    def by_owner(stories)
      stories.group_by{|story| story.owned_by || "Unassigned"}.sort
    end
  end
end
