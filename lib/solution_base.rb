class SolutionBase
  def sample_input
    File.read(File.join(__dir__, '..', 'src', module_dir, 'sample.txt'))
  end

  def actual_input
    File.read(File.join(__dir__, '..', 'src', module_dir, 'actual.txt'))
  end

  private

  def module_dir
    self.class.name.split('::').first.downcase
  end
end
