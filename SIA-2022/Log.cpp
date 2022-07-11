#include "stdafx.h"
#include "Log.h"

#define _CRT_SECURE_NO_WARNINGS

namespace Log
{
	LOG getlog(wchar_t logfile[])
	{
		LOG log;
		log.stream = new std::ofstream;
		log.stream->open(logfile);
		if (log.stream->fail())
			throw ERROR_THROW(112);

		wcscpy_s(log.logfile, logfile);
		return log;
	}

	void WriteLine(LOG log, char* c, ...)
	{
		char** ptr = &c;

		while (*ptr != "")
		{
			*log.stream << *ptr;
			ptr++;
		}

		*log.stream << endl;
	}

	void WriteLine(LOG log, wchar_t* c, ...)
	{
		wchar_t** ptr = &c;

		char temp[300];

		while (*ptr != L"")
		{
			wcstombs(temp, *ptr, sizeof(temp));

			*log.stream << temp;
			ptr++;
		}

		*log.stream << endl;
	}

	void WriteLog(LOG log)
	{

		time_t rawtime;
		tm current_time;
		char temp[100];

		time(&rawtime);
		localtime_s(&current_time, &rawtime);

		*log.stream << "------	Протокол	--------";
		
		strftime(temp, 100, "	%d.%m.%Y, %H:%M:%S	-----------\n", &current_time);
		*log.stream << temp << endl;

	}

	void WriteParm(LOG log, Parm::PARM parm)
	{
		char in_text[PARM_MAX_SIZE];
		char out_text[PARM_MAX_SIZE];
		char log_text[PARM_MAX_SIZE];

		wcstombs(in_text, parm.in, PARM_MAX_SIZE);
		wcstombs(out_text, parm.out, PARM_MAX_SIZE);
		wcstombs(log_text, parm.log, PARM_MAX_SIZE);

		*log.stream << "-----	Параметры	-----"
			<< "\n-in: " << in_text
			<< "\n-out: " << out_text
			<< "\n-log: " << log_text << endl;
	}

	void WriteIn(LOG log, In::IN in)
	{
		*log.stream << "\n-----	 Исходные данные	-----"
			<< "\nКоличество символов: " << in.size
			<< "\nПроигнорировано: " << in.ignor
			<< "\nКоличество строк: " << in.lines << endl;
	}

	void WriteError(LOG log, Error::ERROR error)
	{
		if (log.stream)
		{
			*log.stream << "Ошибка " << error.id
				<< ": " << error.message
				<< ", строка " << error.inext.line
				<< ", позиция" << error.inext.col << endl;
		}
		else
		{
			cout << "Ошибка " << error.id
				<< ": " << error.message
				<< ", строка " << error.inext.line
				<< ", позиция  " << error.inext.col << endl;
		}
	}

	void Close(LOG log)
	{
		log.stream->close();
		delete log.stream;
	}
}