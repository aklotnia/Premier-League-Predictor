import React from 'react'
import { Droppable } from 'react-drag-and-drop'


class LineUpContainer extends React.Component {

    onDrop = (data, position, int) => {
        // => banana 
        // console.log(data)
        let dataAr = data[`${this.props.team.toLowerCase()}${position[0].toLowerCase()}`].split(',')
        let img = document.querySelector(`#${this.props.team}${position}${int}`)
        if (img.alt.includes("Template Silouhette")) {
            img.src = dataAr[1]
            img.alt = dataAr[0]
            this.asyncState(dataAr, position[0].toLowerCase())
        } else {
            alert("This spot has already been chosen")
        }
    }

    async asyncState(ar, position) {
        if (this.props.homeAddPlayer) {
            this.props.homeAddPlayer(ar[0], position)
        } else if (this.props.awayAddPlayer) {
            this.props.awayAddPlayer(ar[0], position)
        }
    }

    render(){
        return(
            <div className="LineUpContainer" id={this.props.id}>
                <img className="SoccerPitchTemplate" src="FootballPitch.png" alt="Soccer Pitch Template" />
                <div>

                </div>
                <div className="ForwardArea">
                    <div className="ForwardAreaRow1">
                        <Droppable className="Forward1" types={[`${this.props.team.toLowerCase()}f`]} onDrop={(data) => {this.onDrop(data, "Forward", 1)}}>
                            <img id={`${this.props.team}Forward1`} className="GameImage"  src="https://resources.premierleague.com/premierleague/photos/players/110x140/Photo-Missing.png" alt="Forward Player Template Silouhette" />
                        </Droppable>
                    </div>
                    <div className="ForwardAreaRow2">
                        <Droppable className="Forward2" types={[`${this.props.team.toLowerCase()}f`]} onDrop={(data) => {this.onDrop(data, "Forward", 2)}}>
                            <img id={`${this.props.team}Forward2`} className="GameImage"  src="https://resources.premierleague.com/premierleague/photos/players/110x140/Photo-Missing.png" alt="Forward Player Template Silouhette"/>
                        </Droppable>
                        <Droppable className="Forward3" types={[`${this.props.team.toLowerCase()}f`]} onDrop={(data) => {this.onDrop(data, "Forward", 3)}}>
                            <img id={`${this.props.team}Forward3`} className="GameImage"  src="https://resources.premierleague.com/premierleague/photos/players/110x140/Photo-Missing.png" alt="Forward Player Template Silouhette"/>
                        </Droppable>
                    </div>
                </div>
                <div className="MidfieldArea"> 
                    <div className="MidfieldAreaRow1">
                        <Droppable className="Midfield1" types={[`${this.props.team.toLowerCase()}m`]} onDrop={(data) => {this.onDrop(data, "Midfield", 1)}}>
                            <img id={`${this.props.team}Midfield1`} className="GameImage"  src="https://resources.premierleague.com/premierleague/photos/players/110x140/Photo-Missing.png" alt="Midfield Player Template Silouhette"/>
                        </Droppable>
                        <Droppable className="Midfield2" types={[`${this.props.team.toLowerCase()}m`]} onDrop={(data) => {this.onDrop(data, "Midfield", 2)}}>
                            <img id={`${this.props.team}Midfield2`} className="GameImage"  src="https://resources.premierleague.com/premierleague/photos/players/110x140/Photo-Missing.png" alt="Midfield Player Template Silouhette"/>
                        </Droppable>
                    </div>
                    <div className="MidfieldAreaRow2">
                        <Droppable className="Midfield3" types={[`${this.props.team.toLowerCase()}m`]} onDrop={(data) => {this.onDrop(data, "Midfield", 3)}}>
                            <img id={`${this.props.team}Midfield3`} className="GameImage"  src="https://resources.premierleague.com/premierleague/photos/players/110x140/Photo-Missing.png" alt="Midfield Player Template Silouhette"/>
                        </Droppable>
                    </div>
                </div>
                <div className="DefenseArea">
                    <div className="DefenseAreaRow1">
                        <Droppable className="Defense1" types={[`${this.props.team.toLowerCase()}d`]} onDrop={(data) => {this.onDrop(data, "Defense", 1)}}>
                            <img id={`${this.props.team}Defense1`} className="GameImage"  src="https://resources.premierleague.com/premierleague/photos/players/110x140/Photo-Missing.png" alt="Defense Player Template Silouhette"/>
                        </Droppable>
                        <Droppable className="Defense2" types={[`${this.props.team.toLowerCase()}d`]} onDrop={(data) => {this.onDrop(data, "Defense", 2)}}>
                            <img id={`${this.props.team}Defense2`} className="GameImage"  src="https://resources.premierleague.com/premierleague/photos/players/110x140/Photo-Missing.png" alt="Defense Player Template Silouhette"/>
                        </Droppable>
                    </div>
                    <div className="DefenseAreaRow2">
                        <Droppable className="Defense3" types={[`${this.props.team.toLowerCase()}d`]} onDrop={(data) => {this.onDrop(data, "Defense", 3)}}>
                            <img id={`${this.props.team}Defense3`} className="GameImage"  src="https://resources.premierleague.com/premierleague/photos/players/110x140/Photo-Missing.png" alt="Defense Player Template Silouhette"/>
                        </Droppable>
                        <Droppable className="Defense4" types={[`${this.props.team.toLowerCase()}d`]} onDrop={(data) => {this.onDrop(data, "Defense", 4)}}>
                            <img id={`${this.props.team}Defense4`} className="GameImage"  src="https://resources.premierleague.com/premierleague/photos/players/110x140/Photo-Missing.png" alt="Defense Player Template Silouhette"/>
                        </Droppable>
                    </div>
                </div>
                <div className="GoalkeepingArea">
                        <Droppable className="Keeper1" types={[`${this.props.team.toLowerCase()}g`]} onDrop={(data) => {this.onDrop(data, "gk", 1)}}>
                            <img id={`${this.props.team}gk1`} className="GameImage"  src="https://resources.premierleague.com/premierleague/photos/players/110x140/Photo-Missing.png" alt="Keeper Player Template Silouhette" />
                        </Droppable>
                </div>
            </div>
        )
    }
}

export default LineUpContainer