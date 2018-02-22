import pandas as pd
from constants import domains

def is_same_server(ltuple, rtuple):
  # Attention, the input argument is not symmetric,
  # dealing with missing data, if either table is missing city, return 0
  if pd.isnull(ltuple['a_web']) or pd.isnull(rtuple['a_email_server']):
    return 0
  # return 1 if is same city, 0 otherwise
  if rtuple['a_email_server'] in ltuple['a_web']:
    return 1
  else:
    return 0

def is_same_single_server(ltuple, rtuple):
  if pd.isnull(ltuple['a_web']) or pd.isnull(rtuple['a_email_server']):
    return 0
  country_domains = domains.COUNTRY
  academic_domains = domains.ACADEMIC
  common_domains = domains.COMMON
  email_server = rtuple['a_email_server'].strip().split('.')

  # The sequence of the following conditional commands is important. It is because the country
  # domains are usually the last one on the right of an email server domain, and it is followed
  # either by academic domain and/or common domain.
  if email_server[-1] in country_domains:
    del email_server[len(email_server)-1]
  if email_server[-1] in academic_domains:
    del email_server[len(email_server)-1]
  if email_server[-1] in common_domains:
    del email_server[len(email_server)-1]
  if email_server[-1] in academic_domains:
    del email_server[len(email_server)-1]

  # return the highest level information only
  cleaned_server = email_server[len(email_server)-1]
  if cleaned_server in ltuple['a_web'].replace('http://','').split("."):
    return 1
  else:
    return 0
