/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 0;                      /* -b  option; if 0, dmenu appears at bottom     */
/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {
	"spleen:size=14"
};
static const char *prompt      = NULL;      /* -p  option; prompt to the left of input field */
/* Monochrome colors */
/* Zenbones-inspired soft monochrome */
static const char col_bg[]    = "#1c1c1c";  // dark grayish background
static const char col_fg[]    = "#d7d7d7";  // soft light foreground
static const char col_gray[]  = "#5f5f5f";  // muted border (not always used in dmenu)
static const char col_selbg[] = "#d7d7d7";  // selection background (light)
static const char col_selfg[] = "#1c1c1c";  // selection foreground (dark text)

/* dmenu color scheme */
static const char *colors[SchemeLast][2] = {
	/*               fg         bg       */
	[SchemeNorm] = { col_fg,    col_bg },    // normal
	[SchemeSel]  = { col_selfg, col_selbg }, // selected
	[SchemeOut]  = { col_fg,    col_bg },    // for output (optional)
};
/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines      = 0;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";

static unsigned int lineheight = 35;
static unsigned int min_lineheight = 35;
