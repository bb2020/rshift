#include "redshift/src/gamma-quartz.h"

quartz_state_t* rs_get_state() {
  static quartz_state_t state = {};
  static int inited = 0;
  if (!inited) {
    quartz_init(&state);
    quartz_start(&state);
    inited = 1;
  }
  return &state;
}

int rs_set_temp(int temp) {
  quartz_state_t* state = rs_get_state();
  color_setting_t scheme = {};
  scheme.temperature = temp;
  scheme.gamma[0] = 1.0;
  scheme.gamma[1] = 1.0;
  scheme.gamma[2] = 1.0;
  scheme.brightness = 1.0;
  return quartz_set_temperature(state, &scheme);
}
