{option-functions, ...}:
with option-functions;
  option null "rice" (cfg: {
    gaps = {
      inner = numberOption "gaps between windows (twice as large, since all windows have them)" 5;
      outer = numberOption "gaps between windows and monitor edges" (cfg.gaps.inner * 2);
    };
  })
