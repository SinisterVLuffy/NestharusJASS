library GetUnitCollision /* v2.0.1.0
*************************************************************************************
*
*   Retrieves collision size for a unit (different from pathing map)
*
*   Assumes collision will always be an integer
*
*   100% accurate to 1 decimal for collision sizes >= 5.1
*
*************************************************************************************
*
*   */uses/*
*
*       */ Table /*             hiveworkshop.com/forums/jass-functions-413/snippet-new-table-188084/
*
*************************************************************************************
*
*   Functions
*
*       function GetUnitCollision takes unit whichUnit returns real
*
************************************************************************************/
    globals
        private Table uc
    endglobals
    
    private function C takes unit u, real x, real y, integer i returns real
        local real l = 0
        local real h = 300
        local real m = 150
        
        loop
            if (IsUnitInRangeXY(u, x+m, y, 0)) then
                set l = m
            else
                set h = m
            endif
            exitwhen l+.005 > h
            set m = (l+h)/2
        endloop
        
        set m = R2I((l + .005)*100)/100.
        
        set uc.real[i] = m
        
        return m
    endfunction
    function GetUnitCollision takes unit u returns real
        local integer i = GetUnitTypeId(u)
        
        if (uc.real.has(i)) then
            return uc.real[i]
        endif
        
        return C(u, GetUnitX(u), GetUnitY(u), i)
    endfunction
    
    private module Initializer
        private static method onInit takes nothing returns nothing
            set uc = Table.create()
        endmethod
    endmodule
    
    private struct init extends array
        implement Initializer
    endstruct
endlibrary
