{option-functions, ...}:
with option-functions;
  option null "rice" (cfg: {
    border_size = numberOption "border size" 2;
    rounding = numberOption "rounding" 8;
    gaps = {
      inner = numberOption "gaps between windows (twice as large, since all windows have them)" 5;
      outer = numberOption "gaps between windows and monitor edges" (cfg.gaps.inner * 2);
    };
  })
