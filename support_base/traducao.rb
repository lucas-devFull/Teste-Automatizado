class Traducao
    include Capybara::DSL
    include RSpec::Matchers

    def traducaoString(idioma, string,filtro)
        @espanhol = {
            sucesso: [ 
                'Las informaciones fueron guardadas con éxito',
                'Registro eliminado con éxito',
                'Exito',
                'Punto del referencia registrado con éxito',
                'El rastreador ya esta activado!',
                'Activado con éxito',
                'Deshabilitado con éxito',
                'Rastreador desinstalado con éxito'
            ],
            erro:[
                'Existen pendientes en el formulario, por favor, revise los datos de la 1° o 3° pestaña',
                'Ha ocurrido un error en el sistema, intente nuevamente ',
            ],
            alerta: [
                'Ningún perfil ha sido seleccionado, por lo que no es posible configurar para acceder al sistema',
                'Registros excluidos no pueden ser recuperados',
                'Es necesario seleccionar un registro',
                'Usted debe seleccionar un registro en la cuadrícula',
                'Desea realmente cancelar la operación ?',
                'Para realizar la eliminación es necesario resolver el/los ítem(s) debajo',
                'No es posible editar/excluir el rastreador, si ya está activo en alguna instalación.',
                'Este rastreador ya esta instalado, para desactivar es necesario eliminar la instalación',
                'No será posible enviar los datos de acceso para el cliente, pues el mismo no posee contactos con el mail principal comprobado .',
                'Existen pendientes en el formulario, por favor, revise los datos de la 1° o 3° pestaña',
            ]
        }
        @ingles = {
            sucesso: [ 
                'The information was successfully saved',
                'Record deleted successfully',
                'Success',
                'Point reference registered successfully',
                'The tracker is already activated!',
                'Ativado com sucesso',
                'Successfully deactivated',
                'Tracker uninstalled Success',
            ],
            erro:[
                'There are pending on the form, please check the data of the 1st or 3rd tab',
                'Ocurred one error in the system plis try again',
            ],
            alerta: [
                'No profile has been selected, so it was not possible to configure to access the system',
                'Excluded records can not be recovered',
                'You must select a record',
                'You must select a record in the Grid',
                'Do you really want to cancel the operation?',
                'To perform the deletion it is necessary above the resolvers',
                'Not possible edit/delete tracker active or Garage',
                'The tracker is installed you need to uninstall',
                'You can not send the access data to the client because it has no contacts with the main checked email .',
                'There are pending on the form, please check the data of the 1st or 3rd tab'
            ]
        }
    
        @portugues = {
            sucesso: [ 
                'As informações foram salvas com sucesso',
                'Registro deletado com sucesso',
                'Sucesso',
                'Ponto de referência cadastrado com sucesso',
                'O rastreador já está ativo!',
                'Ativado com sucesso',
                'Desativado com sucesso',
                'Rastreador desinstalado com sucesso !',
                'Operação realizada com sucesso'

            ],
            erro:[
                'Existem pendências no formulário, por favor, verifique os dados da 1º ou 3º aba.',
                'Ocorreu um erro no sistema, tente novamente !',
            ],
            alerta: [
                'Nenhum perfil foi selecionado, portanto, não foi possível realizar a configuração para acesso ao sistema !',
                'Registros excluidos não podem ser recuperados',
                'É preciso selecionar um registro',
                'Deseja realmente cancelar a operação ?',
                'Para realizar a exclusão, é necessário resolver o(s) item(ns) abaixo',
                'Não é possivel editar/excluir o rastreador se ele estiver ativo ou feito oficina.',
                'Este rastreador já esta instalado, para desativar é preciso remover a instalação',
                'Não será possível enviar os dados de acesso para o cliente, pois o mesmo não possui contatos com o email principal checado .',
                'Existem pendências no formulário, por favor, verifique os dados da 1º ou 3º aba.'
            ]
        }

        if idioma == 1
            return (@portugues[:"#{filtro}"].include?(string)) ? string : false
        elsif idioma == 2
            return (@ingles[:"#{filtro}"].include?(string)) ? string : false
        else
            return (@espanhol[:"#{filtro}"].include?(string)) ? string : false
        end       
    end
end