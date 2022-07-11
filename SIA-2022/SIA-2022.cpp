#include "stdafx.h"

#include "Error.h"
#include "In.h"
#include "Log.h"
#include "Parm.h"


int wmain(int argc, wchar_t* argv[])
{
	setlocale(LC_ALL, "RUS");

	Log::LOG log = Log::INITLOG;
	try
	{
		Parm::PARM parm = Parm::getparm(argc, argv);
		log = Log::getlog(parm.log);
		Log::WriteLine(log, (char*)"Тест: ", (char*)" без ошибок \n", "");
		Log::WriteLine(log, (wchar_t*)L"Тест: ", (wchar_t*)L" без ошибок \n", L"");
		Log::WriteLog(log);
		Log::WriteParm(log, parm);
		In::IN in = In::getin(parm);
		Log::WriteIn(log, in);
		Log::Close(log);

		cout << in.text << endl;
	}
	catch (Error::ERROR e)
	{
		Log::WriteError(log, e);
	}
	

	system("pause");
	return 0;
}