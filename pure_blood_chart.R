# pure_blood_chart.R
# "Pure Blood" — Notes from the Abstract
# Two-panel chart: current blood supply antibody composition vs.
# what the Kentucky bill would have required
# A. Rupert Crocker

library(ggplot2)
library(patchwork)
library(scales)

# ── Palette ──────────────────────────────────────────────────────────────────
cream      <- "#FAF5E9"
cream_panel <- "#FBF8EE"
red        <- "#C0392B"
blue       <- "#2471A3"
dark_text  <- "#3A3A3A"
mid_text   <- "#5A5A5A"
grid_color <- "#E6DECA"

# ── Theme ─────────────────────────────────────────────────────────────────────
theme_1950s <- function() {
  theme_minimal(base_family = "Arial", base_size = 14) +
    theme(
      plot.background   = element_rect(fill = cream, color = NA),
      panel.background  = element_rect(fill = cream, color = NA),
      panel.grid.major  = element_line(color = grid_color, linewidth = 0.6),
      panel.grid.minor  = element_blank(),
      axis.title        = element_text(face = "bold", color = dark_text),
      axis.text         = element_text(color = "#4A4A4A"),
      plot.title        = element_text(face = "bold", size = 20, color = dark_text),
      plot.subtitle     = element_text(size = 13, color = mid_text),
      plot.margin       = margin(15, 15, 15, 15),
      legend.position   = "none"
    )
}

# ── Data ──────────────────────────────────────────────────────────────────────
# Current supply: 96.4% of donors carry COVID-19 antibodies
# Source: CDC seroprevalence report, 2022 [Andrew to verify primary citation]
# Kentucky bill would have required blood negative for COVID-19 antibodies
# and synthetic mRNA — effectively inverting the eligible pool

current <- data.frame(
  category = c("Antibody-positive donors\n(96.4%)", "Antibody-negative donors\n(3.6%)"),
  pct      = c(96.4, 3.6),
  fill     = c(red, cream_panel)
)

required <- data.frame(
  category = c("Would remain eligible\n(3.6%)", "Would be disqualified\n(96.4%)"),
  pct      = c(3.6, 96.4),
  fill     = c(red, cream_panel)
)

# Force factor order so antibody-positive / eligible always plots first
current$category  <- factor(current$category,  levels = current$category)
required$category <- factor(required$category, levels = required$category)

# ── Panel A: Current supply ───────────────────────────────────────────────────
p_current <- ggplot(current, aes(x = "", y = pct, fill = category)) +
  geom_col(width = 0.6, color = dark_text, linewidth = 0.8) +
  geom_text(
    aes(label = paste0(pct, "%")),
    position = position_stack(vjust = 0.5),
    size     = 5.5,
    fontface = "bold",
    color    = c(cream, dark_text),
    family   = "Arial"
  ) +
  scale_fill_manual(values = setNames(current$fill, current$category)) +
  scale_y_continuous(labels = percent_format(scale = 1), limits = c(0, 100)) +
  labs(
    title    = "The Supply Today",
    subtitle = "Who is actually donating blood",
    x        = NULL,
    y        = "Share of donor pool"
  ) +
  theme_1950s() +
  theme(
    axis.text.x  = element_blank(),
    axis.ticks.x = element_blank()
  )

# ── Panel B: What the Kentucky bill required ──────────────────────────────────
p_required <- ggplot(required, aes(x = "", y = pct, fill = category)) +
  geom_col(width = 0.6, color = dark_text, linewidth = 0.8) +
  geom_text(
    aes(label = paste0(pct, "%")),
    position = position_stack(vjust = 0.5),
    size     = 5.5,
    fontface = "bold",
    color    = c(dark_text, cream),
    family   = "Arial"
  ) +
  scale_fill_manual(values = setNames(required$fill, required$category)) +
  scale_y_continuous(labels = percent_format(scale = 1), limits = c(0, 100)) +
  labs(
    title    = "The Supply the Bill Required",
    subtitle = "Who would have remained eligible",
    x        = NULL,
    y        = NULL
  ) +
  theme_1950s() +
  theme(
    axis.text.x  = element_blank(),
    axis.ticks.x = element_blank()
  )

# ── Combined layout ───────────────────────────────────────────────────────────
combined <- p_current + p_required +
  plot_annotation(
    title    = "What 'Unvaccinated Blood' Would Have Left",
    subtitle = "The Kentucky bill would have disqualified 96.4% of the current donor pool",
    caption  = "Sources: CDC seroprevalence report (2022); Louisville Public Media (2025)\nNotes from the Abstract · andrewrcrocker.substack.com",
    theme    = theme(
      plot.background = element_rect(fill = cream, color = NA),
      plot.title      = element_text(
        face   = "bold",
        size   = 22,
        color  = dark_text,
        family = "Arial",
        margin = margin(b = 6)
      ),
      plot.subtitle = element_text(
        size   = 14,
        color  = mid_text,
        family = "Arial",
        margin = margin(b = 12)
      ),
      plot.caption = element_text(
        size   = 10,
        color  = mid_text,
        family = "Arial",
        hjust  = 0,
        margin = margin(t = 12)
      )
    )
  )

# ── Save ──────────────────────────────────────────────────────────────────────
ggsave(
  filename = "pure_blood_chart.png",
  plot     = combined,
  width    = 1456 / 96,
  height   = 900  / 96,
  dpi      = 96,
  bg       = cream
)

message("Chart saved: pure_blood_chart.png")
