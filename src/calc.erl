%%% -------------------------------------------------------------------
%%% @author  : Joq Erlang
%%% @doc: : 
%%% Manage Computers
%%% 
%%% Created : 
%%% -------------------------------------------------------------------
-module(calc). 

-behaviour(gen_server).
%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------
%-include("timeout.hrl").
%-include("log.hrl").
%-include("config.hrl").
%% --------------------------------------------------------------------


%% --------------------------------------------------------------------
%% Key Data structures
%% 
%% --------------------------------------------------------------------
-record(state, {services}).



%% --------------------------------------------------------------------
%% Definitions 
%% --------------------------------------------------------------------
-export([services/0	 
	]).

-export([boot/0,
	 start/0,
	 stop/0,
	 ping/0
	]).

%% gen_server callbacks
-export([init/1, handle_call/3,handle_cast/2, handle_info/2, terminate/2, code_change/3]).


%% ====================================================================
%% External functions
%% ====================================================================

%% Asynchrounus Signals

boot()->
    application:start(?MODULE).

%% Gen server functions

start()-> gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).
stop()-> gen_server:call(?MODULE, {stop},infinity).


ping()-> 
    gen_server:call(?MODULE, {ping},infinity).

%%-----------------------------------------------------------------------

services()-> 
    gen_server:call(?MODULE, {services},infinity).
   
%%----------------------------------------------------------------------


%% ====================================================================
%% Server functions
%% ====================================================================

%% --------------------------------------------------------------------
%% Function: init/1
%% Description: Initiates the server
%% Returns: {ok, State}          |
%%          {ok, State, Timeout} |
%%          ignore               |
%%          {stop, Reason}
%
%% --------------------------------------------------------------------

init([]) ->
    
    ok=application:start(common),
    ok=application:start(adder_service),
    ok=application:start(divi_service),
    ok=application:start(multi_service),
   
  %  {ok,[{application,adder_service,InfoAdder_service}]}=file:consult("/ebin/adder_service.app"),
  %  {vsn,VsnAdder_service}=lists:keyfind(vsn,1,InfoAdder_service),
    
  %  {ok,[{application,divi_service,InfoDivi_service}]}=file:consult("./ebin/divi_service.app"),
  %  {vsn,VsnDivi_service}=lists:keyfind(vsn,1,InfoDivi_service),

  %  {ok,[{application,multi_service,InfoMulti_service}]}=file:consult("./ebin/multi_service.app"),
%    {vsn,VsnMulti_service}=lists:keyfind(vsn,1,InfoMulti_service),

 %   {ok,[{application,common,InfoCommon}]}=file:consult("./ebin/common.app"),
 %   {vsn,VsnCommon}=lists:keyfind(vsn,1,InfoCommon),

 %   {ok,[{application,calc,InfoApp}]}=file:consult("./ebin/calc.app"),
 %   {vsn,VsnApp}=lists:keyfind(vsn,1,InfoApp),

 %   io:format("~p~n",["./ebin/common.app"]),
   
 %   io:format("~p~n",[InfoCommon]),

  %  io:format("~p~n",[VsnCommon]),
  
    {ok, #state{services=[{"adder_service"},
			  {"divi_service"},
			  {"multi_service"},
			  {"common"},
			  {"calc"}
			 ]}}.

%% --------------------------------------------------------------------
%% Function: handle_call/3
%% Description: Handling call messages
%% Returns: {reply, Reply, State}          |
%%          {reply, Reply, State, Timeout} |
%%          {noreply, State}               |
%%          {noreply, State, Timeout}      |
%%          {stop, Reason, Reply, State}   | (terminate/2 is called)
%%          {stop, Reason, State}            (aterminate/2 is called)
%% --------------------------------------------------------------------
handle_call({ping},_From,State) ->
    Reply={pong,node(),?MODULE},
    {reply, Reply, State};


handle_call({services},_From,State) ->
    Reply=State#state.services,
    {reply, Reply, State};

handle_call({stop}, _From, State) ->
    {stop, normal, shutdown_ok, State};

handle_call(Request, From, State) ->
    Reply = {unmatched_signal,?MODULE,Request,From},
    {reply, Reply, State}.

%% --------------------------------------------------------------------
%% Function: handle_cast/2
%% Description: Handling cast messages
%% Returns: {noreply, State}          |
%%          {noreply, State, Timeout} |
%%          {stop, Reason, State}            (terminate/2 is called)
%% -------------------------------------------------------------------
			     
handle_cast(Msg, State) ->
    io:format("unmatched match cast ~p~n",[{?MODULE,?LINE,Msg}]),
    {noreply, State}.

%% --------------------------------------------------------------------
%% Function: handle_info/2
%% Description: Handling all non call/cast messages
%% Returns: {noreply, State}          |
%%          {noreply, State, Timeout} |
%%          {stop, Reason, State}            (terminate/2 is called)
%% --------------------------------------------------------------------

handle_info(Info, State) ->
    io:format("unmatched match info ~p~n",[{?MODULE,?LINE,Info}]),
    {noreply, State}.


%% --------------------------------------------------------------------
%% Function: terminate/2
%% Description: Shutdown the server
%% Returns: any (ignored by gen_server)
%% --------------------------------------------------------------------
terminate(_Reason, _State) ->
    ok.

%% --------------------------------------------------------------------
%% Func: code_change/3
%% Purpose: Convert process state when code is changed
%% Returns: {ok, NewState}
%% --------------------------------------------------------------------
code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%% --------------------------------------------------------------------
%%% Internal functions
%% --------------------------------------------------------------------
%% --------------------------------------------------------------------
%% Function: 
%% Description:
%% Returns: non
%% --------------------------------------------------------------------

%% --------------------------------------------------------------------
%% Internal functions
%% --------------------------------------------------------------------

%% --------------------------------------------------------------------
%% Function: 
%% Description:
%% Returns: non
%% --------------------------------------------------------------------
