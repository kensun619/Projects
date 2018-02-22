# coding: utf-8
import re
import py_entitymatching as em

def match_country(ltuple, rtuple):
  l_country = ltuple['a_country']
  r_country = rtuple['a_country']
  if (l_country == "") or (r_country == ""):
    return None
  else:
    return ( l_country == r_country)

def match_country_us(ltuple, rtuple):
  return (rtuple['a_country'] == "united states")

def match_prov(ltuple, rtuple):
  l_prov = ltuple['a_prov']
  r_prov = rtuple['a_prov']
  if (l_prov == "") or (r_prov == ""):
    return None
  else:
    return (l_prov == r_prov)

def match_city(ltuple, rtuple):
  l_city = ltuple['a_city']
  r_city = rtuple['a_city']
  if (l_city  == "") or (r_city == ""):
    return None
  else:
    return (l_city == r_city)

def match_domain(ltuple, rtuple):
  l_web = str(ltuple['a_web'])
  r_email = str(rtuple['a_email_server_cleaned'])
  if (l_web == "") or (r_email == ""):
    return None
  else:
    l_web = l_web.split('.')
    return (r_email in l_web)

def match_overlap(ltuple, rtuple):
  l_name = str(ltuple['a_name'])
  r_name = str(rtuple['a_name'])

  if (l_name == "") or (r_name == ""):
    return None
  else:
    if l_name.count(" ") > 0 and r_name.count(" ") > 0:
      l_name = re.sub(r"(university|school|institute|college)","",l_name)
      r_name = re.sub(r"(university|school|institute|college)","",r_name)
      l_tokens = em.tok_wspace(l_name)
      r_tokens = em.tok_wspace(r_name)
      return em.overlap_coeff(l_tokens, r_tokens) > 0.5
    else:
      return None

def allFalse(array):
  num_none = array.count(None)
  num_false = array.count(False)
  return (num_none + num_false) == len(array) and num_none != len(array)


def match_combined(ltuple, rtuple):
  if match_country(ltuple, rtuple) is False:
    return True
  elif (match_country_us(ltuple,rtuple) is True) and (match_prov(ltuple,rtuple) is False):
    return True
  elif (match_country_us(ltuple,rtuple) is True) and (allFalse([match_overlap(ltuple, rtuple),
                                                                 match_domain(ltuple, rtuple)]) is True):
    return True
  elif (match_country_us(ltuple,rtuple) is False) and allFalse([match_overlap(ltuple, rtuple),
                                                                 match_domain(ltuple, rtuple)]) is True:
    return True
  else:
    return False

def blocking(A, B, headers_A, headers_B):
  bb = em.BlackBoxBlocker()
  bb.set_black_box_function(match_combined)
  C = bb.block_tables(A, B, l_output_attrs=headers_A, r_output_attrs=headers_B)
  return C
