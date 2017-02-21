class Editor < Step
  add_alias :editor

  def setup
    # TODO: Add ability to specify editor in ~/.wrkflorc
    @editor = :sublime

    @step = Step.create(@editor, config, project)
  end

  def run;    @step.run;    end
  def unrun;  @step.unrun;  end
end
