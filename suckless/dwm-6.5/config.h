#include <X11/XF86keysym.h>
/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const unsigned int systraypinning = 0;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayonleft = 0;    /* 0: systray in the right corner, >0: systray on left of status text */
static const unsigned int systrayspacing = 2;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray        = 1;        /* 0 means no systray */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "Spleen 8x16:style=Medium:pixelsize=23" };
static const char dmenufont[]       = "Spleen 8x16:style=Medium:pixelsize=23";
static const char col_gray1[]       = "#1c1c1c";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#005577";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class            instance     title       tags mask      isfloating  monitor */
    { "st-256color",      NULL,       NULL,       1 << 0,        0,          0 },
    { "Chromium-browser", NULL,       NULL,       1 << 1,        0,          0 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *termcmd[]  = { "st", NULL };
static const char *lockcmd[] = { "xlock", NULL };
static const char scratchpadname[] = "scratchpad";
static const char *scratchpadcmd[] = { "st", "-t", scratchpadname, "-g", "120x34", NULL };
/* Media keys */
static const char *volup[]    = { "amixer", "-q", "sset", "Master", "5%+", "unmute", NULL  };
static const char *voldown[]  = { "amixer", "-q", "sset", "Master", "5%-", "unmute", NULL  };
static const char *volmute[]  = { "amixer", "-q", "sset", "Master", "toggle", NULL  };
static const char *play[]     = { "playerctl", "play-pause", NULL  };
static const char *next[]     = { "playerctl", "next",   NULL  };
static const char *prev[]     = { "playerctl", "previous",   NULL  };
static const char *stop[]     = { "playerctl", "pause",   NULL  };
static const char *lightinc[] = { "light", "-A", "10"  };
static const char *lightdec[] = { "light", "-U", "10" };

static const Key keys[] = {
	/* modifier                 key             function        argument */
	{ MODKEY,                   XK_p,           spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,         XK_Return,      spawn,          {.v = termcmd } },
    { MODKEY|ShiftMask,         XK_BackSpace,   togglescratch,  {.v = scratchpadcmd } },
	{ MODKEY,                   XK_b,           togglebar,      {0} },
	{ MODKEY,                   XK_j,           focusstack,     {.i = +1 } },
	{ MODKEY,                   XK_k,           focusstack,     {.i = -1 } },
	{ MODKEY,                   XK_i,           incnmaster,     {.i = +1 } },
	{ MODKEY,                   XK_d,           incnmaster,     {.i = -1 } },
	{ MODKEY,                   XK_h,           setmfact,       {.f = -0.05} },
	{ MODKEY,                   XK_l,           setmfact,       {.f = +0.05} },
	{ MODKEY,                   XK_Return,      zoom,           {0} },
	{ MODKEY,                   XK_Tab,         view,           {0} },
	{ MODKEY|ShiftMask,         XK_c,           killclient,     {0} },
	{ MODKEY,                   XK_t,           setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                   XK_f,           setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                   XK_m,           setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                   XK_space,       setlayout,      {0} },
	{ MODKEY|ShiftMask,         XK_space,       togglefloating, {0} },
	{ MODKEY,                   XK_0,           view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,         XK_0,           tag,            {.ui = ~0 } },
	{ MODKEY,                   XK_comma,       focusmon,       {.i = -1 } },
	{ MODKEY,                   XK_period,      focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,         XK_comma,       tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,         XK_period,      tagmon,         {.i = +1 } },
	TAGKEYS(                    XK_1,                           0)
	TAGKEYS(                    XK_2,                           1)
	TAGKEYS(                    XK_3,                           2)
	TAGKEYS(                    XK_4,                           3)
	TAGKEYS(                    XK_5,                           4)
	//TAGKEYS(                    XK_6,                           5)
	//TAGKEYS(                    XK_7,                           6)
	//TAGKEYS(                    XK_8,                           7)
	//TAGKEYS(                    XK_9,                           8)
	{ MODKEY|ShiftMask,         XK_q,           quit,           {0} },
    { MODKEY|ShiftMask,         XK_l,           spawn,          {.v = lockcmd} },
    { MODKEY,                   XK_Insert,      spawn,           SHCMD("xdotool type $(grep -v '^#' ~/.suckless/bookmarks | dmenu -fn 'Modern DOS 8x16:pixelsize=23' -i -l 50 | cut -d' ' -f1)")  },
    /* Audio & Brightness */
    { 0,    XF86XK_AudioRaiseVolume,  spawn,          {.v = volup } },
    { 0,    XF86XK_AudioLowerVolume,  spawn,          {.v = voldown } },
    { 0,    XF86XK_AudioMute,         spawn,          {.v = volmute } },
    { 0,    XF86XK_AudioPlay,         spawn,          {.v = play } },
    { 0,    XF86XK_AudioNext,         spawn,          {.v = next } },
    { 0,    XF86XK_AudioPrev,         spawn,          {.v = prev } },
    { 0,    XF86XK_AudioStop,         spawn,          {.v = stop } },
    { 0,    XF86XK_MonBrightnessDown, spawn,          {.v = lightdec } },
    { 0,    XF86XK_MonBrightnessUp,   spawn,          {.v = lightinc } },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

