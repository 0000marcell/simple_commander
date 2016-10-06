module SimpleCommander
  module Methods
    include SimpleCommander::UI
    include SimpleCommander::UI::AskForClass
    include SimpleCommander::Delegates

    if $stdin.tty? && (cols = $terminal.output_cols) >= 40
      $terminal.wrap_at = cols - 5
    end
  end
end
