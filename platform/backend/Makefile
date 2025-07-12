VENV:=venv

PIP:=$(VENV)/bin/pip
PYTHON:=$(VENV)/bin/python3
PYTEST:=$(VENV)/bin/pytest

$(VENV):
	$(SYSTEM_PYTHON) -m venv venv

.PHONY: pip-install
pip-install: $(VENV)
	$(PIP) install --upgrade pip
	$(PIP) install -r requirements.txt

.PHONY: pip-install-dev
pip-install-test: $(VENV)
	$(PIP) install -r requirements-dev.txt
