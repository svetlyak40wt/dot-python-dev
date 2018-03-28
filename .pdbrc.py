from pdb import DefaultConfig, Color

class Config(DefaultConfig):
    """This is a config for pdb++.
    """

    bg = 'light'
    filename_color = Color.darkgreen
    line_number_color = Color.brown
    current_line_color = int(Color.darkred)
    encoding = 'utf-8'
    # Это нужно из-за того, что при подтсветке кода иногда ломаются докстринги
    # и комменты на русском.
    use_pygments = False

    def setup(self, pdb):
        Pdb = pdb.__class__
        Pdb.do_st = Pdb.do_sticky
