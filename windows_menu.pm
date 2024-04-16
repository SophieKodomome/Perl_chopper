#!/usr/bin/perl
use strict;
use warnings;
use Tk;
use Tk::PNG;
use Tk::JPEG;
use lib '.';

#use Windows_game;

package Windows_menu;

#create instance
sub new {
    my ($class) = @_;
    my $self = {
        mw => MainWindow->new,
        canvas => undef,
        rectangle => undef,
    };
    bless $self, $class;
    $self->_init;
    return $self;
}

sub _init {
    my ($self) = @_;
    $self->pre;
    my $mw = $self->{mw};

    my $titre = $self->{mw}->Photo(-format => 'png', -file => "img/title.png");
    $self->{rectangle} = $self->{canvas}->createImage(800, 350, -image => $titre);

    $self->{button} = $self->create_play_button;
}


# button
sub create_play_button {
    my $self = shift;

    my $play_button = $self->{mw}->Button(
        -text => "Play",
        -font => "{EnterCommand} 64",
        -background => "#fdeae0",      # Couleur de fond
        -foreground => "#0a143f",      # Couleur du texte
        -activebackground => "#0a143f",# Couleur de fond lors du survol
        -activeforeground => "#f64967",# Couleur du texte lors du survol
        -borderwidth => 10,             # Pas de bordure
        -highlightthickness => 0,      # Pas de mise en évidence
        -padx => 100,                   # Remplissage horizontal
        -pady => 14,                   # Remplissage vertical
        -command => sub { $self->button_click },    # Action à exécuter lors du clic
    );
    $play_button->configure(
        -relief => 'flat',             # Pas de relief
        -highlightcolor => "#EBD3EA",  # Couleur de mise en évidence
    );
    $play_button->place(
        -relx => 0.5,
        -rely => 0.65,
        -anchor => 'center',
    );
    return $play_button;
}
#sub button_click {
#    my $self = shift;
#    require Windows_game; 
#    Windows_game->new->run; 
#    $self->{mw}->destroy; 
#}


sub pre {
    my ($self) = @_;

    # Récupérer les dimensions de l'écran
    my $screen_width  = $self->{mw}->screenwidth;
    my $screen_height = $self->{mw}->screenheight;

    # Déterminer les dimensions et la position de la fenêtre pour la centrer
    my $window_width  = 1536;
    my $window_height = 864;
    my $x_position = int(($screen_width - $window_width) / 2);
    my $y_position = int(($screen_height - $window_height) / 2);

    # Générer la géométrie de la fenêtre pour la centrer
    my $geometry = $window_width . 'x' . $window_height . '+' . $x_position . '+' . $y_position;
    $self->{mw}->geometry($geometry);

    # Supprimer la barre de titre
    $self->{mw}->overrideredirect(1);

    # Créer le canevas et dessiner le rectangle
    $self->{canvas} = $self->{mw}->Canvas(-width => $window_width, -height => $window_height)->pack;

    # Charger l'image à utiliser comme arrière-plan
    my $background_image_file = 'img/bckgrnd.jpg';  
    my $background_image = $self->{mw}->Photo(-file => $background_image_file);

    # Créer un label pour afficher l'image en arrière-plan
    my $background_label = $self->{canvas}->createImage(0, 0, -image => $background_image, -anchor => 'nw');

    # $self->{rectangle} = $self->{canvas}->createRectangle(50, 50, 150, 150, -fill => 'blue');

    # Lier l'événement de pression de la touche "x" à la fermeture de la fenêtre
    $self->{mw}->bind('<KeyPress-x>', sub { $self->{mw}->destroy });
}

sub run {
    my $self = shift;
    Tk::MainLoop;
}

1;