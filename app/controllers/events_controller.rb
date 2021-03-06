# -*- coding: utf-8 -*-
class EventsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]

  # GET /events
  # GET /events.json
  def index
    if params[:username].present?
      @artist = User.confirmed.find_by_username(params[:username])

      if @artist.present?
        @events = @artist.events.refine_search(params).paginate(page: params[:page])
        @tags = @artist.events.refine_search(params).tag_counts
        @json = @artist.events.refine_search(params).all.collect{|event| event.spot }.to_gmaps4rails  if @artist.events.refine_search(params).present?
      else
        redirect_to events_path, alert: "ご指定のアーティストは見つかりませんでした"
        return
      end
    else
      @events = Event.refine_search(params).paginate(page: params[:page])
      @tags = Event.refine_search(params).tag_counts
      @json = Event.refine_search(params).all.collect{|event| event.spot }.to_gmaps4rails if Event.refine_search(params).present?
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    @gmaps_options = {
      "map_options" => {
        "auto_zoom" => false,
        "zoom" => 13,
        "center_latitude" => @event.spot.latitude,
        "center_longitude" => @event.spot.longitude
      },
      "markers" => {
        "data" => @event.spot.to_gmaps4rails
      }
    }

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new

    if params[:spot_id] && Spot.find_by_id(params[:spot_id])
      @event.spot = Spot.find_by_id(params[:spot_id])
    else
      @event.build_spot
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = current_user.events.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @event = current_user.events.build(params[:event])

    respond_to do |format|
      if @event.save
        if params[:twitter] == 'yes'
          current_user.twitter.update(@event.title[0..80] + " ... " + url_for(controller: "events",action: "show", id: @event))
        end
        if params[:facebook] == 'yes'
          current_user.facebook.feed!(
            message: @event.title,
            description: @event.description,
            link: url_for(controller: "events",action: "show", id: @event)
          )
        end
        NotificationMailer.event_registration_notification(@event).deliver
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = current_user.events.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        if params[:twitter] == 'yes'
          current_user.twitter.update(@event.title[0..80] + " ... " + url_for(controller: "events",action: "show", id: @event))
        end
        if params[:facebook] == 'yes'
          current_user.facebook.feed!(
            message: @event.title,
            description: @event.description,
            link: url_for(controller: "events",action: "show", id: @event)
          )
        end
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = current_user.events.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
end
