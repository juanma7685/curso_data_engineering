{% macro get_current_year() %}
  {{ return(env_var('CURRENT_YEAR', date().year)) }}
{% endmacro %}
