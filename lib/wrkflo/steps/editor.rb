class Editor < Step
  add_alias :editor

  def init
    @editor = Profile.options['editor']
    @name = "editor[#{@editor}]"
    @step = Step.create(@editor, config, project)
  end

  def run;    @step.run;    end
  def unrun;  @step.unrun;  end
end
