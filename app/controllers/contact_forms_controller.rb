# -*- coding: utf-8 -*-
class ContactFormsController < ApplicationController

  def new
    @contact_form = ContactForm.new
  end

  def create
    begin
      @contact_form = ContactForm.new(params[:contact_form])
      @contact_form.request = request
      if @contact_form.deliver
        redirect_to root_path, notice: '正常にお問い合わせが送られました'
      else
        render :new
      end
    rescue ScriptError
      redirect_to root_path, error: 'お問い合わせの送信に失敗しました'
    end
  end
end
