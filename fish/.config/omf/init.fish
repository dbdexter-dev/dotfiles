set -g theme_color_scheme 'user'

#               light  medium dark
#               ------ ------ ------
set -l red      cc9999 ce000f 660000
set -l green    addc10 189303 0c4801
set -l blue     48b4fb 005faf 255e87
set -l orange   f6b117 unused 3a2a03
set -l brown    bf5e00 803f00 4d2600
set -l grey     cccccc 999999 333333
set -l white    ffffff
set -l black    000000
set -l ruby_red af0000

set -g __color_initial_segment_exit     $white $red[2] --bold
set -g __color_initial_segment_su       $white $green[2] --bold
set -g __color_initial_segment_jobs     $white $blue[3] --bold

set -g __color_path                     $grey[3] $grey[2]
set -g __color_path_basename            $grey[3] $white --bold
set -g __color_path_nowrite             $red[3] $red[1]
set -g __color_path_nowrite_basename    $red[3] $red[1] --bold

set -g __color_repo                     $green[1] $green[3]
set -g __color_repo_work_tree           $grey[3] $white --bold
set -g __color_repo_dirty               $red[2] $white
set -g __color_repo_staged              $orange[1] $orange[3]

set -g __color_vi_mode_default          white $grey[3] --bold
set -g __color_vi_mode_insert           $green[1] $grey[3] --bold
set -g __color_vi_mode_visual           $orange[1] $orange[3] --bold

set -g __color_vagrant                  $blue[1] $white --bold
set -g __color_username                 $grey[1] $blue[3]
set -g __color_rvm                      $ruby_red $grey[1] --bold
set -g __color_virtualfish              $blue[2] $grey[1] --bold
