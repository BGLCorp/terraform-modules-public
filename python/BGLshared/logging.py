import logging
import datetime
import os
from pythonjsonlogger import jsonlogger

# Add custom logging
class CustomJsonFormatter(jsonlogger.JsonFormatter):
    def add_fields(self, log_record, record, message_dict):
        super(CustomJsonFormatter, self).add_fields(log_record, record, message_dict)
        if not log_record.get('timestamp'):
            # this doesn't use record.created, so it is slightly off
            now = datetime.datetime.now().strftime('%Y-%m-%dT%H:%M:%S.%fZ')
            log_record['timestamp'] = now
        if log_record.get('level'):
            log_record['level'] = log_record['level'].upper()
        else:
            log_record['level'] = record.levelname
        if log_record.get('logger'):
            log_record['logger'] = log_record['logger']
        else:
            log_record['logger'] = record.name
        if not log_record.get('stack_trace'):
            log_record['stack_trace'] = record.exc_info


logger = logging.getLogger()
logger.setLevel(level=os.getenv('LOG_LEVEL', default='INFO').upper())
logHandler = logging.StreamHandler()
formatter = CustomJsonFormatter('%(message)s %(level)s %(logger)s %(timestamp)s %(stack_trace)s')
logHandler.setFormatter(formatter)
logger.addHandler(logHandler)