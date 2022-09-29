class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, except: [:index, :new, :create]
  def index

    public_group = Group.public_group
    own_group = current_user.groups.where.not(privacy: :public_group)
    @groups = own_group + public_group
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.user = current_user
    if @group.save
      @group.members.create(member_id: current_user.id, role: :admin, user_id: current_user.id, status: "confirmed")
      flash[:notice] = "Group created successfully!"
      redirect_to groups_path
    else
      flash[:alert] = "Group created failed!"
      render :new
    end
  end

  def edit; end

  def update
    if @group.update(group_params)
      flash[:notice] = "Group updated successfully!"
      redirect_to groups_path
    else
      flash[:alert] = "Group failed to edit!"
      render :edit
    end
  end

  def show; end

  def destroy
    if @group.destroy
      flash[:notice] = "Group deleted successfully!"
    else
      flash[:alert] = "Group failed to delete!"
    end
    redirect_to groups_path
  end

  private

  def group_params
    params.require(:group).permit(:name, :description, :banner, :privacy)
  end

  def set_group
    @group = Group.find(params[:group_id] || params[:id])
  end

end
