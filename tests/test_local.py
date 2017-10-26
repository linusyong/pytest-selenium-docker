
import pytest
import requests
from selenium import webdriver
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities

@pytest.fixture(scope="module")
def browser():
  browser = webdriver.Remote(command_executor='http://localhost:4444/wd/hub',
    desired_capabilities=DesiredCapabilities.CHROME)
  yield browser
  browser.quit()

class TestSample(object):
  def test_return_code(self, base_url):
    try:
      assert requests.codes.ok == requests.get(base_url).status_code
    except requests.exceptions.ConnectionError as e:
      print(str(e))
      assert str(e) == ""
  
  def test_page_titles(self, browser, base_url):
    browser.get(base_url)
    assert "Hello World" in browser.title
