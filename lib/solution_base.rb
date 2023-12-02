class SolutionBase
  def sample_input_one
    File.read(File.join(__dir__, '..', 'src', module_dir, 'sample1.txt'))
  end

  def sample_input_two
    File.read(File.join(__dir__, '..', 'src', module_dir, 'sample2.txt'))
  end

  def actual_input
    File.read(File.join(__dir__, '..', 'src', module_dir, 'actual.txt'))
  end

  private

  def module_dir
    self.class.name.split('::').first.downcase
  end
end
