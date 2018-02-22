# coding: utf-8
import re
import csv
import pandas as pd
from constants import countries, states, cities, domains

class Cleaner:
  def __init__(self, csv_path, index_column, used_headers, encoding = 'UTF-8'):
    self.index_column = index_column
    self.data = pd.read_csv(csv_path, encoding = encoding, index_col = index_column, usecols = used_headers)

  def data(self):
    return data

  def to_csv(self, filename):
    self.data.to_csv(filename, encoding = 'UTF-8', index_label = self.index_column)

  ### CLEAN AFFILIATION INFORMATION
  def clean_affiliation(self, a_name):
    n = self.data[a_name].size
    for i in range(0, n):
      name = self.data[a_name].iloc[i].strip()
      name = name.replace('U.','University').lower()
      name = re.sub(r"(\bthe\s|\sof\s|\sat\s|\sin\s|,|-|&|\(|\)|('\s*s\s)|\.)", " ", name)
      name = re.sub(r'\s+', " ", name)
      self.data[a_name].iloc[i] = name.strip()
    return self.data[a_name]

  ### CLEAN EMAIL SERVER INFORMATION
  # This function aims to return the essential/ importantant information from individuals' email
  # server domain. For example, in the case of email server of "wharton.upenn.edu" and university
  # website address of "http://www.upenn.edu", important is the information "upenn". This is
  # because we want to map affiliations at the university level, instead of the school level,
  #  e.g. Wharton is the business school of University of Pensylvenia. Subsequently, a feature will
  #  capture whether the essential information is contained in the affiliation's website address

  # In order to extract the important information, we eliminate (1) country domains (e.g. "au" is
  # Australia's country domain), (2) academic domains (i.e. "edu" and "ac" )), and (3) common domains
  # (e.g. "com, "net", "info"). After eliminating these domains, we take the first info - which
  # is supposed to capture the highest level of domain at the affiliation level. For example, in
  # the case of "wharton.upenn.edu", after eliminating the abovementioned domains, we will have
  # "wharton.upenn", of which "upenn" is at the university level and "wharton" is at the school
  # level. We will only capture the university-evel info, i.e. "upenn"


  # EXAMPLE:
  # "Catolica Lisbon School of Business and Economics" - is the business school of Catholic U. Portugal
  # AOM's email server domain: "clsbe.lisboa.ucp.pt" ; WHED's affiliation website: "http://www.ucp.pt"
  # -----
  # The essential information of the email server domain is "ucp"
  # "ucp" appears in the affiation website
  # --> This helps link school to university !!!!!!!! YAYYYYYYY
  def clean_email_server(self, a_email_server):
    country_domains = domains.COUNTRY
    academic_domains = domains.ACADEMIC
    common_domains = domains.COMMON

    self.data[a_email_server+"_cleaned"] = self.data[a_email_server]
    n = self.data[a_email_server].size

    for i in range (0, n):
      email_server = self.data[a_email_server].iloc[i].strip().split('.')

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
      self.data[a_email_server+"_cleaned"].iloc[i] = email_server[len(email_server)-1]
    return self.data[a_email_server+"_cleaned"]

  ### CLEAN CITY INFORMATION
  def clean_city(self, a_city):
    D = cities.CITIES

    n = self.data[a_city].size
    for i in range (0, n):
      if self.data[a_city].iloc[i] in D:
        self.data[a_city].iloc[i] = D[self.data[a_city].iloc[i]]
      if isinstance(self.data[a_city].iloc[i], str):
        city = self.data[a_city].iloc[i]
        city = re.sub(r"(\sof\s|\sat\s|\sin\s|,|-|&|\(|\)|')", " ", city)
        city = re.sub(r'\s+', " ", city)
        self.data[a_city].iloc[i] = city.lower().strip()
      else:
        self.data[a_city].iloc[i] = ""

    return self.data[a_city]

  ### CLEAN COUNTRY INFORMATION
  def clean_country(self, a_country):
    country_dict = countries.COUNTRIES
    n = self.data[a_country].size
    for i in range (0, n):
      self.data[a_country].iloc[i] = self.data[a_country].iloc[i].strip()
      if self.data[a_country].iloc[i].strip() in country_dict:
        self.data[a_country].iloc[i] = country_dict[self.data[a_country].iloc[i]]

      self.data[a_country].iloc[i] = self.data[a_country].iloc[i].lower().strip()
    return self.data[a_country]

  ### CLEAN STATES INFORMATION
  def clean_states(self, a_prov, a_country):
    us_states = states.US_STATES
    n = self.data[a_prov].size
    for i in range (0, n):
      if self.data[a_prov].iloc[i] in us_states:
        if isinstance(us_states[self.data[a_prov].iloc[i]], str):
          self.data[a_prov].iloc[i] = us_states[self.data[a_prov].iloc[i]]
        else:
          self.data[a_country].iloc[i] = us_states[self.data[a_prov].iloc[i]]["country"]
          self.data[a_prov].iloc[i] = us_states[self.data[a_prov].iloc[i]]["province"]

      self.data[a_prov].iloc[i] = str(self.data[a_prov].iloc[i]).lower().strip().replace("nan", "")

    return (self.data[a_prov], self.data[a_country])
