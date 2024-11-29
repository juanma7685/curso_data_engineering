{% macro get_today() %}
  {{ return(env_var('TODAY', date(now()).isoformat())) }}
{% endmacro %}
